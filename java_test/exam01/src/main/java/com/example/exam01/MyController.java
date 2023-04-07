package com.example.exam01;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.servlet.http.HttpServletRequest;


@Controller
public class MyController {
    
    @Autowired
    private MemberDAO mdao;
    

    // 홈페이지 인덱스 페이지
    @RequestMapping("/")
    public String doHome() {
        return "home";
    }

    // 로그인 페이지
    @RequestMapping("/login")
    public String doLogin() {
        return "login";
    }

    // 회원가입 페이지
    @RequestMapping("/signin")
    public String doSignin() {
        return "signin";
    }

    //아이디&비밀번호 찾기
    @RequestMapping("/find")
    public String doFind() {
        return "find";
    }

    // 아이디 찾기
    @RequestMapping("/find_id")
    @ResponseBody
    public String doFind_id(@RequestParam("name") String name, @RequestParam("email") String email, @RequestParam("phoneNumber") String phoneNumber) {
        Member member = mdao.findByNameAndEmailAndPhoneNumber(name, email, phoneNumber);

        if (member == null) {
            return "fail"; // 사용자 아이디 반환
        } 
        else {
            return member.getUserid();
        }
    }


    // 비밀번호 찾기
    @RequestMapping("/find_password")
    @ResponseBody
    public String doFindPassword(@RequestParam("userid") String userid, @RequestParam("email") String email) {
        Member member = mdao.findByUseridAndEmail(userid, email);

        if(member == null) {
            return "fail";
        }
        else {
            return member.getPassword();
        }
    }

    // // "user"라는 이름으로 새로운 'Member' 객체를 생성하여 모델에 추가
    // @GetMapping("/viewUser")
    // public String doViewUser(Model model) {
    //     model.addAttribute("users", new Member());
    //     return "viewUser";
    // }

    // // 'member' 객체를 MongoDB 데이터베이스에 저장
    // @PostMapping("/viewUser")
    // public String newUser(Member member) {
    //     mdao.save(member);
    //     return "redirect:/login";
    // }

    // 'member' 객체를 MongoDB 데이터베이스에 저장
    @RequestMapping("/viewUser")
    public String doNewUser(HttpServletRequest req) {
        String retval = "";
        try{
            String userid = req.getParameter("userid");
            String password = req.getParameter("password");
            String name = req.getParameter("name");
            String nickname = req.getParameter("nickname");
            String email = req.getParameter("email");   
            String phoneNumber = req.getParameter("phoneNumber");
            
            Member member = new Member();
            // Member member = new Member(userid,password,name,nickname,email,phoneNumber);
            // member.(userid,password,name,nickname,email,phoneNumber);
            member.setUserid(userid);
            member.setPassword(password);
            member.setName(name);
            member.setNickname(nickname);
            member.setEmail(email);
            member.setPhoneNumber(phoneNumber);
            
            mdao.save(member);
            retval = "ok";
        }
        catch(Exception e) {
            retval = "fail";
            // e.printStackTrace();
        }
        return retval;
    }

    // 로그인시 등록되어있는 사용자인지 확인
    @RequestMapping("/loginOk")
    public String doLoginOk(Member member) {
        Member m = mdao.findByUserid(member.getUserid());
        if (m != null && m.getPassword().equals(member.getPassword())) {
            return "/";
        }
        else {
            return "login";
        }
    }

    // @RequestMapping("/checkUser")
    // @ResponseBody
    // public String doCheckUser(HttpServletRequest req) {
    //     try {
    //         String loginId = req.getParameter("userid");
    //         String pw = req.getParameter("password");
            
    //     }
    //     return "";
    // }

    // 세션
    // @RequestMapping("/loginCheck")
    // @ResponseBody
    // public String doLoginCheck(HttpServletRequest req) {
    //     HttpSession session = req.getSession();
    //     String userid = (String)session.getAttribute("lUserid");
    //     if (userid = null || userid.equals("")) {
    //         return "";
    //     }
    //     return "";
    // }

    // 아이디 중복확인하는 코드
    @PostMapping("/checkId")
    @ResponseBody
    public String doCheckId(@RequestParam String userid) {
        boolean isDup = mdao.checkId(userid);
        return Boolean.toString(isDup);
    }

    // 닉네임 중복확인하는 코드
    @PostMapping("/checkNick")
    @ResponseBody
    public String doCheckNick(@RequestParam String nickname) {
        boolean isDup = mdao.checkNick(nickname);
        return Boolean.toString(isDup);
    }

    // 이메일 중복확인하는 코드
    @PostMapping("/checkEmail")
    @ResponseBody
    public String doCheckEmail(@RequestParam String email) {
        boolean isDup = mdao.checkEmail(email);
        return Boolean.toString(isDup);
    }  

}


