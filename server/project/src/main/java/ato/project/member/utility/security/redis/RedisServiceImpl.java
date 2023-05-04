package ato.project.member.utility.security.redis;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class RedisServiceImpl implements RedisService{
    private final StringRedisTemplate redisTemplate;

    @Override
    public void setKeyAndValue(String token, Long memNo) {
        String memNoToString = String.valueOf(memNo);
        ValueOperations<String, String> value = redisTemplate.opsForValue();
        value.set(token, memNoToString);
    }

    @Override
    public Long getValueByKey(String token) {
        ValueOperations<String, String> value = redisTemplate.opsForValue();
        String tempMemNo = value.get(token);
        Long memNo;
        if(tempMemNo == null){
            memNo = null;
        } else {
            memNo = Long.parseLong(tempMemNo);
        }
        return memNo;
    }

    @Override
    public void deleteByKey(String token) {
        redisTemplate.delete(token);
    }
}
