package ato.project.memberTest;

import ato.project.member.service.MemberService;
import ato.project.member.utility.security.redis.RedisService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
public class memberTest {

    @Autowired
    private MemberService memberService;

    @Test
    public void registerMember(){
        System.out.println(memberService.registerMember());
    }

}
