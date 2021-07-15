/* 기본 설정 */
"use Lax";
document.cookie = "safeCookie1=foo; SameSite=Lax";
document.cookie = "safeCookie2=foo";
document.cookie = "crossCookie=bar; SameSite=None; Secure";


// API 키 값
const key = "zr1b84xnwsyh165gmr4t1r0ib";
const sid = "pz9zGcVGqTm"; // 메타포트 모델 아이디 ----> 메타포트 변경 할 시 해당 아이디 수정
const params = "&help=0&hr=0&play=1&qs=1&brand=0";
var iframe;

// 메타포트 로드
document.addEventListener("DOMContentLoaded", () => {
    iframe = document.querySelector('.showcase');
    iframe.setAttribute('src', `https://my.matterport.com/show/?m=${sid}${params}`);
    iframe.addEventListener('load', showcaseLoader);

    let overlay = document.querySelector('.right-overlay');
    let title = document.querySelector('.overlay-title');
    let tags = document.querySelector('.nearby-tags');
    tags.style.display = 'none';
    let arrow = overlay.querySelector('.overlay-arrow');
    title.addEventListener('click', () => {
        tags.style.display = tags.style.display === 'flex' ? 'none' : 'flex';
        arrow.classList.toggle('active');
    });
});

function showcaseLoader(){
    try {
        window.MP_SDK.connect(iframe, key, '3.9')
        .then(loadedShowcaseHandler)
        .catch(console.error);
    }
    catch (e) {
        console.error(e);
    }
}
/* ---------------------- */
function euclideanDistance3D(pos1, pos2){
    return Math.sqrt( 
        Math.pow(pos1.x - pos2.x, 2) +
        Math.pow(pos1.y - pos2.y, 2) +
        Math.pow(pos1.z - pos2.z, 2)
     );
}

function removeElementsInside(ele){
    while(ele.firstChild){
        ele.removeChild(ele.lastChild);
    }
}

function loadedShowcaseHandler(mpSdk){
    console.log("mpSdk:", mpSdk);
    // Initial setup
    removeAllTags();
    let questions = loadQuestions();
    let sweeps = getModelSweeps()
    let mattertags = questions.map(question => question.tag);
    let sortFunc = (a, b) => a.distance - b.distance;
    

    mattertags.forEach(tag => tag.discPosition = mpSdk.Mattertag.getDiscPosition(tag));

    let cursweep;
    

    setTimeout(() => {
        cursweep = Object.keys(sweeps)[0];
        updateNearbyTags(cursweep);
        let sameLevelTags = getTagProximity(cursweep);
        testList(sameLevelTags);
    }, 3000);


    // Listeners
    mpSdk.on(mpSdk.Sweep.Event.ENTER, (oldSweep, newSweep) => {
        cursweep = newSweep;
        updateNearbyTags(newSweep);
        
    });

    mpSdk.on(mpSdk.Mattertag.Event.HOVER, (sid, hovering) => {
        let existing_overlay = document.querySelector('.popup-overlay');
        if(existing_overlay) existing_overlay.remove();
        popupQuestion(sid);
    });

    mpSdk.Camera.pose.subscribe(function (pose) {
        // Changes to the Camera pose have occurred.
        console.log('Current position is ', pose.position);
        console.log('Rotation angle is ', pose.rotation);
        console.log('Sweep UUID is ', pose.sweep);
        console.log('View mode is ', pose.mode);
      });
    

    

    /* 메타포트 하단 점수 판 생성 함수 */
    function testList(tags){
        let main = document.querySelector(".answer-check");


        let table = document.createElement("table");
        table.setAttribute("class", "table");
        table.setAttribute("border", 1);

        let col1 = document.createElement("th");
        let col2 = document.createElement("th");
        col1.innerText = `문제`;
        col2.innerText = `답`;

        table.insertAdjacentElement('beforeend',col1);
        table.insertAdjacentElement('beforeend',col2);


        tags.forEach(tag => {
            let question = getQuestion(tag.sid);

            let tagTr = document.createElement("tr");
            tagTr.setAttribute("class", "tag-tr");
            tagTr.setAttribute("id", tag.sid);

            let tagTd1 = document.createElement("td");
            tagTd1.setAttribute("class", "goto-"+tag.sid);
            tagTd1.setAttribute("id", tag.sid);
            tagTd1.innerText = tag.label + ``;

            let tagTd2 = document.createElement("td");
            tagTd2.setAttribute("id", "td"+tag.sid);
            tagTd2.innerText = `문제를 풀어주세요.`;

            tagTr.insertAdjacentElement('beforeend', tagTd1);
            tagTr.insertAdjacentElement('beforeend', tagTd2);

            table.insertAdjacentElement('beforeend', tagTr);
        });
        main.insertAdjacentElement('beforeend', table);
    }

    function getTagProximity(sweepID){
        console.log("sweepID:",sweepID); // 밑에 동그라미 부분 ID
        let sameLevelTags = []; 
        let newSweep = sweeps[sweepID];
        mattertags.forEach(tag => tag.distance = euclideanDistance3D(tag.discPosition, newSweep.position));
        // sameLevelTags = mattertags.filter(tag => Math.abs(tag.discPosition.y - newSweep.position.y) <= 2.25);
        sameLevelTags = mattertags;
        sameLevelTags.sort(sortFunc);
        // return sameLevelTags.length >= 5 ? sameLevelTags.slice(0, 4) : sameLevelTags;
        return sameLevelTags
    }

    function updateNearbyTags(sweepID){
        let sameLevelTags = getTagProximity(sweepID);
        let container = document.querySelector('.nearby-tags');
        removeElementsInside(container);
        //let ele = createTagElements(sameLevelTags, container);
        //test code
        console.log("level tag:",sameLevelTags);
        setTagListeners(ele);
    }

    function getModelSweeps(){
        let sweeps = [];
        mpSdk.Model.getData()
        .then(data => {
            data.sweeps.forEach(sweep => {
                sweeps[sweep.uuid] = sweep;
            });
        })
        .catch(console.error);
        return sweeps;
    }

    function getQuestion(tagID){
        return questions.filter(question => question.tag.sid == tagID)[0];
    }


    //====== 퀴즈 생성 함수 
    function createQuestionElement(question){
        // Container
        let container = document.createElement('div');
        container.setAttribute('class', 'popup-overlay');

        // Exit
        let exit = document.createElement('p');
        exit.setAttribute('class', 'popup-exit');
        exit.innerText = "X";
        container.insertAdjacentElement('beforeend', exit);

        // Title
        let title = document.createElement('h5');
        title.setAttribute('class', 'popup-title');
        title.innerText = question.title;
        //container.insertAdjacentElement('beforeend', title);
        
        let audio = document.createElement('audio');
        audio.setAttribute('id', 'auto_play');
        audio.setAttribute('controls',"");

        let audio_source = document.createElement('source');
        audio_source.setAttribute('src', question.tag.mediaSrc);
        audio_source.setAttribute('type', 'audio/mp3');
        
        audio.insertAdjacentElement('beforeend', audio_source);
        
        // 설명 모달 창 생성
        let modal = document.createElement('div');
        modal.setAttribute('id', "modal-"+question.tag.sid);
        modal.setAttribute('class','modal');
        modal.style.height = "1000px";
        modal.style.maxWidth = "400px";
        let modal_pic;
        
        // 미디어 타입 별 document 생성
        if (question.tag.mediaType === "3d"){
            modal_pic = document.createElement('model-viewer');
            modal_pic.setAttribute('class','modal-3d');
            modal_pic.setAttribute('src',question.tag.picSrc);
            modal_pic.setAttribute('auto-rotate', "ture");
            modal_pic.setAttribute('camera-controls', "ture");
        }else if(question.tag.mediaType === "video"){
            modal_pic = document.createElement('video');
            modal_pic.setAttribute('class','modal-video');
            modal_pic.setAttribute('src', question.tag.media.src);
            modal_pic.setAttribute('controls', "controls");
        }else if(question.tag.mediaType === 'pic'){
            modal_pic = document.createElement('img');
            modal_pic.setAttribute('class','modal-img');
            modal_pic.setAttribute('src',question.tag.picSrc);
        }

        // 모달 설명 열기 닫기 버튼 생성
        let modal_content = document.createElement('p');
        modal_content.setAttribute('id', "modal-"+question.tag.sid);
        modal_content.innerHTML = question.description;
        console.log(question.description);

        let close_modal = document.createElement('a');
        close_modal.setAttribute('type','button');
        close_modal.setAttribute('class','btn btn-danger');
        close_modal.setAttribute('href','#');
        close_modal.setAttribute('rel','modal:close');
        close_modal.innerHTML = `설명닫기`;
        modal.insertAdjacentElement('beforeend', modal_pic);
        modal.insertAdjacentElement('beforeend', modal_content);
        modal.insertAdjacentElement('beforeend', close_modal);

        let modal_tag = document.querySelector(".modal-content");
        modal_tag.insertAdjacentElement('beforeend', modal);


        let open_modal = document.createElement('button');
        open_modal.setAttribute("class","btn");
        let open_modal_link = document.createElement('a');
        open_modal_link.setAttribute('type','button');
        open_modal_link.setAttribute('class','btn btn-info');
        open_modal_link.setAttribute('href','#modal-'+question.tag.sid);
        open_modal_link.setAttribute('rel','modal:open');
        open_modal_link.innerHTML = `설명보기`;
        open_modal.insertAdjacentElement('beforeend',open_modal_link);

        //description.insertAdjacentElement('beforeend', audio);
        //description.insertAdjacentElement('beforeend', open_modal);
        //description.insertAdjacentElement('beforeend', modal);
        //container.insertAdjacentElement('beforeend', description);

        // 사진 추가
        //container.insertAdjacentElement('beforeend', modal_pic2);
        container.insertAdjacentElement('beforeend', modal_pic);

        // Question status
        
        // textBox
        let textBox = document.createElement('div');
        textBox.setAttribute('class','container');
        container.insertAdjacentElement('beforeend', textBox);


        let status  = document.createElement('h6');
        let status2 = document.createElement('h6');
        let status3 = document.createElement('h6');
        let status4 = document.createElement('h6');

        status.setAttribute('class', 'popup-status');
        status2.setAttribute('class', 'popup-status');
        status3.setAttribute('class', 'popup-status');
        status4.setAttribute('class', 'popup-status');

        status.innerText = "호텔 7층에 위치한 갤러리 7은 중소규모 회의, 가족 행사, VIP 파티 및 유명 브랜드 론칭 등 고객 니즈에 맞는 특별한 경험을 준비해 드립니다. 호텔 셰프가 준비해 드리는 최상급 제철 식재료로 만든 창의적인 요리를 즐길 수 있는 공간도 마련되어 있습니다.";
        
        textBox.insertAdjacentElement('beforeend', status);

        status2.innerText = "- 7개의 미팅 룸 및 최대 100명까지 수용 가능";

        textBox.insertAdjacentElement('beforeend', status2);

        status3.innerText = "Gallery 7, situated on the hotel’s seventh floor, offers optimal venues for small-to-medium scale business conferences, family celebrations, VIP parties and luxury brand launches. An additional venue serves creative culinary offerings crafted by hotel chefs from the finest seasonal ingredients.";

        textBox.insertAdjacentElement('beforeend', status3);

        status4.innerText = "- 7 meeting rooms and capacity of up to 100 guests";

        textBox.insertAdjacentElement('beforeend', status4);


        return container;
    }

    //====== 정답 체크 함수
    function setPopupListeners(questionEle, question){
        let answer;
        let td;
        let cur_score;
        let choices = questionEle.querySelectorAll('input');
        let status = questionEle.querySelector('.popup-status');
        let exit = questionEle.querySelector('.popup-exit');
        exit.addEventListener('click', e => {
            questionEle.remove();
        });

        choices.forEach(choice => {
            choice.addEventListener('change', newVal => {
                // TODO: propogate to right overlay
                if(newVal.target.value === question.answer){
                    answer = question.tag.sid
                    td = document.getElementById("td"+answer);
                    td.innerText = `정답입니다!`;
                    td.style.color = "rgb(103, 255, 103)";
                    status.innerText = "정답입니다!";

                    status.style.color = "rgb(103, 255, 103)";
                    question.tag.color = {r: 0, g: 1, b: 0};
                    question.tag.score = 1
                    mpSdk.Mattertag.editColor(question.tag.sid, {r: 0, g: 1, b: 0})
                    .catch(console.error);
                }else{
                    answer = question.tag.sid
                    td = document.getElementById("td"+answer);
                    td.innerText = `정답이 아닙니다!`;
                    td.style.color = "rgb(255, 103, 103)";
                    status.innerText = "정답이 아닙니다!";
                    status.style.color = "rgb(255, 103, 103)";
                    question.tag.color = {r: 1, g: 0, b: 0};
                    question.tag.score = 0
                    mpSdk.Mattertag.editColor(question.tag.sid, {r: 1, g: 0, b: 0})
                    .catch(console.error);
                }
                mpSdk.Mattertag.editBillboard(question.tag.sid, {
                    description: status.innerText
                })
                .catch(console.error);
                console.log("스코어:",question.tag.score);
                updateNearbyTags(cursweep);
            });
        });
       
    }

    function popupQuestion(tagID){
        console.log("tagid:", tagID);
        let question = getQuestion(tagID);
        let questionEle;
        if(question.hasOwnProperty("element")){
            questionEle = question.element;
        }else{
            questionEle = createQuestionElement(question);
            setPopupListeners(questionEle, question);
            question.element = questionEle;
        }
        iframe.insertAdjacentElement('beforebegin', questionEle);
    }


    function setTagListeners(container){
        container.childNodes.forEach(tagEle =>{
            let goto = tagEle.querySelector('#goto');
            goto.addEventListener('click', e => {
                let existing_overlay = document.querySelector('.popup-overlay');
                if(existing_overlay) existing_overlay.remove();
                mpSdk.Mattertag.navigateToTag(tagEle.id, mpSdk.Mattertag.Transition.FADE)
                .catch(console.error);
                popupQuestion(tagEle.id);
            });

            let description = tagEle.querySelector('#description');
            let arrow = tagEle.querySelector('#arrow');

            let title = tagEle.querySelector('#title');
            title.addEventListener('click', e => {
                description.style.display = description.style.display === 'inherit' ? 'none' : 'inherit';
                arrow.classList.toggle('active');
            });

        });
    }

    function removeAllTags(){
        mpSdk.Mattertag.getData()
        .then(tags => {
            return tags.map(tag => tag.sid);
        })
        .then(tagSids => {
            return mpSdk.Mattertag.remove(tagSids)
        })
        .catch(console.error);
    }

    function createMattertag(question){
        mpSdk.Mattertag.add(question.tag)
        .then(sid => {
            question.tag.sid = sid[0];
        })
        .catch(console.error);
    }


    //====== 소개말
    // JSON 수정해서 내부 데이터 수정
    function loadQuestions(){
        let questions = [
            {
                //"title": "사진 테스트.",
                //"description": "환영합니다.",
                //"answer": "3",
                "choices": ["세형 동검", "고인돌", "민무늬토기", "뗀석기"],
                "tag": {
                    "sid": "kMF3VzNIslo",
                    //"label": "사진테스트 아닌 것을 고르시오.",
                    "description": "페어몬트 앰배서더 서울에 오신 것을 환영합니다.",
                    //"parsedDescription": [],
                    "picSrc" : "data/gallery7.jpg",
                    //"mediaSrc": "data/audio_sample.mp3",
                    "mediaType": "pic",
                    "media": {
                        "type": "none",
                        "src": ""
                    },
                    // 태그 좌표
                    "anchorPosition": {
                        "x": 25.194637803552613,
                        "y": 0.11316032673505849,
                        "z": -9.62699409890729
                    },
                    "anchorNormal": {
                        "x": -0.001,
                        "y": 1.000,
                        "z": -0.003
                    },
                    "color": {
                        "r": 0,
                        "g": 0,
                        "b": 1
                    },
                    "enabled": true,
                    // 같은 좌표 다른 위치
                    "stemVector": {
                        "x": 0,
                        "y": 1,
                        "z": 0
                    },
                    "stemVisible": true,
                    "score" :0
                }
            }
        ];

        // 입력한 json을 기준으로 태그 생성
        questions.forEach(question => {
            createMattertag(question);
        });
        return questions;
    }
}