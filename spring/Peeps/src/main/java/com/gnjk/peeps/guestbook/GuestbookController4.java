/*
 * package com.gnjk.peeps.guestbook;
 * 
 * import java.io.IOException;
 * 
 * import javax.servlet.http.HttpServletRequest;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.ModelAttribute; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam;
 * 
 * import com.gnjk.peeps.guestbook.domain.GuestbookEditRequest; import
 * com.gnjk.peeps.guestbook.domain.GuestbookRequest; import
 * com.gnjk.peeps.guestbook.service.GuestbookDeleteService; import
 * com.gnjk.peeps.guestbook.service.GuestbookEditService; import
 * com.gnjk.peeps.guestbook.service.GuestbookInsertService; import
 * com.gnjk.peeps.guestbook.service.GuestbookListService;
 * 
 * @Controller //@RequestMapping("/guestbook") public class GuestbookController4
 * {
 * 
 * db서비스
 * 
 * @Autowired private GuestbookInsertService insertService;
 * 
 * @Autowired private GuestbookDeleteService deleteService;
 * 
 * @Autowired private GuestbookEditService editService;
 * 
 * @Autowired private GuestbookListService listService;
 * 
 * guestbook 메인 화면
 * 
 * @RequestMapping(value = "/guestbook", method = RequestMethod.GET) public
 * String getguestbookForm() {
 * 
 * return "/menu/guestbookForm";
 * 
 * }
 * 
 * guestbook from으로 데이터 입력 submit 사용 없어질 예정 ?
 * 
 * @RequestMapping(value = "/guestbook", method = RequestMethod.POST) public
 * String guestbookComplete(@ModelAttribute("insertdata") GuestbookRequest
 * gRequest, HttpServletRequest request, Model model) throws
 * IllegalStateException, IOException { System.out.println("확인용" + gRequest);
 * int result = insertService.guestbook(gRequest, request);
 * model.addAttribute("result", result); // 확인용 //
 * model.addAttribute("gphoto",gRequest.getGphoto().getOriginalFilename()); //
 * model.addAttribute("gmessage",gRequest.getGmessage());
 * 
 * return "/menu/guestbookForm"; }
 * 
 * guestbook 삭제서비스
 * 
 * @RequestMapping("/guestbook/delete")
 * 
 * public String deleteMsg(@RequestParam("gidx") int gidx, Model model) { // 0
 * or 1 model.addAttribute("result", deleteService.deleteMsg(gidx));
 * 
 * return "menu/delete"; }
 * 
 * 수정
 * 
 * @RequestMapping(value = "/guestbook/edit", method = RequestMethod.GET) public
 * String editForm(@RequestParam("gidx") int gidx, Model model) {
 * model.addAttribute("guestbook", editService.getMsg(gidx));
 * 
 * return "menu/editForm";
 * 
 * }
 * 
 * 수정 값 전달
 * 
 * @RequestMapping(value = "/guestbook/edit", method = RequestMethod.POST)
 * public String editGuestbook(GuestbookEditRequest editRequest,
 * HttpServletRequest request, Model model) { System.out.println(editRequest);
 * int result = editService.editGuestbook(editRequest, request);
 * System.out.println(result); model.addAttribute("result", result);
 * 
 * return "menu/edit"; }
 * 
 * 리스트 출력
 * 
 * @RequestMapping("guestbook/list") public String
 * guestbookList(@RequestParam(value = "p", defaultValue = "1") int page, Model
 * model) {
 * 
 * // GuestbookListView listView =listService.getListView(page); //
 * System.out.println(listView); model.addAttribute("listView",
 * listService.getListView(page)); return "/menu/list"; }
 * 
 * }
 */