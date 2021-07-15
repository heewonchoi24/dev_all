/* 기본 설정 */
"use Lax";
document.cookie = "safeCookie1=foo; SameSite=Lax";
document.cookie = "safeCookie2=foo";
document.cookie = "crossCookie=bar; SameSite=None; Secure";


// API 키 값
const key = "zr1b84xnwsyh165gmr4t1r0ib";
const sid = "mqJbb94P8jG"; // 메타포트 모델 아이디 ----> 메타포트 변경 할 시 해당 아이디 수정
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
        //testList(sameLevelTags);
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
        modal.style.height = "100px";
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
        
        //textBox
        let textBox = document.createElement('div');

        let status  = document.createElement('h6');
        let status2 = document.createElement('h6');

        status.setAttribute('class', 'popup-status');
        status2.setAttribute('class', 'popup-status');

        if (question.tag.seq === "1"){
            status.innerText  = "페어몬트 앰배서더 서울에 오신 것을 환영합니다.";
            status2.innerText = "Warm welcome to the Fairmont Ambassador Seoul!";
            container.insertAdjacentElement('beforeend', modal_pic);
        }
        
        if (question.tag.seq === "2"){
            container.setAttribute('class', 'popup-overlay2');
            status.innerText  = "그랜드볼룸은 고객의 니즈에 따른 맞춤형 서비스를 제공합니다. 대형 디스플레이 화면과 최첨단 음향 시스템을 포함한 최신 시청각 기술로 수준 높은 행사를 준비해 드립니다. 그랜드볼룸 맞은편에 위치한 2개의 중소규모 미팅룸 레드우메, 피노는  회의, 세미나 및 기타 행사에 적합하도록 설계되어 있습니다.";
            status2.innerText = "The hotel’s first basement floor Grand Ballroom delivers a range of private services, fully customizable in accordance with the needs of every guest. The latest audio-visual technology, including large display screens and cutting-edge sound systems, further elevate each exceptional event. Located opposite the Grand Ballroom, red Ume and Pino are two small-to-medium-scale meeting rooms, designed to host meetings, seminars and other events with up to 90 guests.";
        }

        container.insertAdjacentElement('beforeend', status);
        container.insertAdjacentElement('beforeend', status2);

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
       
    }

    function popupQuestion(tagID){
        let question = getQuestion(tagID);
        let questionEle;
        if(question.hasOwnProperty("element")){
            questionEle = question.element;
            //questionEle = createQuestionElement(question);
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
                "choices": ["세형 동검", "고인돌", "민무늬토기", "뗀석기"],
                "tag": {
                    "sid": "mqJbb94P8jG",
                    "seq": "1",
                    //"label": "사진테스트 아닌 것을 고르시오.",
                    "description": "페어몬트 앰배서더 서울에 오신 것을 환영합니다.",
                    //"parsedDescription": [],
                    "picSrc" : "data/lobby.jpg",
                    "mediaType": "pic",
                    "media": {
                        "type": "none",
                        "src": ""
                    },
                    // 태그 좌표
                    "anchorPosition": {
                        "x": -0.480,
                        "y": 7.428,
                        "z": 19.422
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
                        "y": 1.5,
                        "z": 0
                    },
                    "stemVisible": true,
                    "score" :0
                }
            },
            {
                "choices": ["세형 동검", "고인돌", "민무늬토기", "뗀석기"],
                "tag": {
                    "sid": "mqJbb94P8jG",
                    "seq": "2",
                    //"label": "사진테스트 아닌 것을 고르시오.",
                    "description": "페어몬트 앰배서더 서울에 오신 것을 환영합니다.",
                    "parsedDescription": [],
                    "picSrc" : "data/lobby.jpg",
                    "mediaType": "pic",
                    "media": {
                        "type": "none",
                        "src": ""
                    },
                    // 태그 좌표x
                    "anchorPosition": {
                        "x": -6.834,
                        "y": -0.035,
                        "z": 29.769
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
                        "y": 1.5,
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