package com.example.exam01;

import org.springframework.data.mongodb.repository.MongoRepository;

public interface MemberDAO extends MongoRepository<Member, String> {

    // 아이디 찾는 메소드
    Member findByUserid(String userid);

    // 닉네임 찾는 메소드
    Member findByNickname(String nickname);
    
    // 이메일 찾는 메소드
    Member findByEmail(String email);

    // 이름 찾는 메소드
    Member findByName(String name);

    // 아이디 찾는 메소드
    Member findByNameAndEmailAndPhoneNumber(String name, String email, String phoneNumber);

    // 비밀번호 찾는 메소드
    Member findByUseridAndEmail (String userid, String email);
    
    // 아이디중복확인 하는 코드
    default boolean checkId(String userid) {
        return findByUserid(userid) != null;
    }

    // 닉네임중복확인 하는 코드
    default boolean checkNick(String nickname) {
        return findByNickname(nickname) != null;
    }

    // 이메일중복확인 하는 코드
    default boolean checkEmail(String email) {
        return findByEmail(email) != null;
    }

    

}
