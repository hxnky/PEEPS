package com.gnjk.chat.controller;

import java.util.List;

import javax.inject.Inject;
import javax.servlet.http.HttpSession;
import javax.websocket.server.PathParam;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.gnjk.chat.domain.Message;
import com.gnjk.chat.service.SendService;

@Controller
@RequestMapping(value = "/test", method = RequestMethod.GET)
public class ListController {
	
	private List<Message> messages;
	
	@Inject
	private SendService sendservice;
	
		// "p" 파라미터가 존재하지 않으므로 기본 값으로 지정한 " "을 "p" 요청 파라미터의 값으로 사용하게 되고, 따라서 rm_idx 파라미터의 값은 ""이 된다.   
		// 우리 채팅의 경우 채팅 아이콘을 클릭하면 채팅 페이지로 넘어간다. 그 즉시 상대방 rm_idx에 맞는 채팅 리스트를 뿌려줘야하는데 이걸 어떻게 해야하나. . homecontroller에 넣어야하는걸까........... 
		public String getAllMessages(@PathVariable("rm_idx") int rm_idx, Message message, Model model, HttpSession session) throws Exception {
		
			
			model.addAttribute("listView", sendservice.selectList(message, rm_idx, session));
			return "test"; 
		}
}



	// service -> ok  (따로 분리해야할까..? )ㅠ
	// dao - > 약간 모르겠음
	// controller... 문제
	// jsp하나도 못함.. 슈벌 (객체로 받아서..... json으로... 변환해서 출력하라고..)
	
	
		/*
	@Controller
@RequestMapping("/board/*")
public class BoardCotroller {

    @Inject
    private BoardService service;

    @RequestMapping(value="/boardList.do", method=RequestMethod.GET)
    public String boardList(BoardVO boardVO, Model model) {
        List<BoardVO> list = service.boardList(boardVO);
        model.addAttribute("list", list);
        
        return "board/boardlist";
    }
			
}
*/