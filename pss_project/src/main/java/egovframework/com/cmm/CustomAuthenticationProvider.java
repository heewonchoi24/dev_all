package egovframework.com.cmm;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.ssis.pss.cmn.util.SHAPasswordEncoder;

/**
 * Created by mskim on 2017-04-06.
 */
public class CustomAuthenticationProvider implements AuthenticationProvider {

    @Override
    public boolean supports(Class<?> authentication) {
        return authentication.equals(UsernamePasswordAuthenticationToken.class);
    }

    @Override
    public Authentication authenticate(Authentication authentication)
            throws AuthenticationException {

        String user_id = (String)authentication.getPrincipal();
        String user_pw = (String)authentication.getCredentials();

        List<GrantedAuthority> roles = new ArrayList<GrantedAuthority>();
        roles.add(new SimpleGrantedAuthority("ROLE_USER"));

        SHAPasswordEncoder shaPasswordEncoder = new SHAPasswordEncoder(256);
        shaPasswordEncoder.setEncodeHashAsBase64(true);
        user_pw = shaPasswordEncoder.encode(user_pw);

        UsernamePasswordAuthenticationToken result = new UsernamePasswordAuthenticationToken(user_id, user_pw, roles);
        result.setDetails(new CustomUserDetails(user_id, user_pw));
        return result;
    }
}