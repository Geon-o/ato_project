package ato.project.member.service;

import ato.project.member.entity.Member;
import ato.project.member.repository.MemberRepository;
import ato.project.member.utility.security.EncryptionUtil;
import ato.project.member.utility.security.redis.RedisService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.UUID;

@Slf4j
@Service
public class MemberServiceImpl implements MemberService{

    @Autowired
    private MemberRepository memberRepository;

    @Autowired
    private RedisService redisService;

    @Override
    public Long registerMember() {
        UUID createToken = UUID.randomUUID();
        String userToken = createToken.toString();

        Member member = new Member();
        member.setAuthentication(EncryptionUtil.generateHash(userToken));

        memberRepository.save(member);

        redisService.deleteByKey(userToken);
        redisService.setKeyAndValue(userToken, member.getMemberId());

        return redisService.getValueByKey(userToken);
    }
}
