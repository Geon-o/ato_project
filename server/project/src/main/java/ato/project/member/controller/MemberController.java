package ato.project.member.controller;

import ato.project.member.service.MemberService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@Slf4j
@RestController
@RequestMapping("/member")
@CrossOrigin(origins = "*", allowedHeaders = "*")
public class MemberController {

    @Autowired
    private MemberService memberService;


    @PostMapping("/register")
    public Long registerMember() {
        log.info("registerMember()");

        return memberService.registerMember();
    }

}
