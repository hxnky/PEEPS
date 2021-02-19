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
 * org.springframework.web.bind.annotation.PostMapping; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam; import
 * org.springframework.web.bind.annotation.ResponseBody;
 * 
 * import com.gnjk.peeps.guestbook.domain.GuestbookEditRequest; import
 * com.gnjk.peeps.guestbook.domain.GuestbookRequest; import
 * com.gnjk.peeps.guestbook.service.GuestbookDeleteService; import
 * com.gnjk.peeps.guestbook.service.GuestbookEditService3; import
 * com.gnjk.peeps.guestbook.service.GuestbookInsertService; import
 * com.gnjk.peeps.guestbook.service.GuestbookListService;
 * 
 * @Controller public class GuestbookController3 {
 * 
 * db서비스
 * 
 * @Autowired private GuestbookInsertService insertService;
 * 
 * @Autowired private GuestbookDeleteService deleteService;
 * 
 * @Autowired private GuestbookEditService3 editService;
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
 * //=======================================================
 * //=======================================================
 * 
 * // 방명록 삭제 2021.2.19 남서아 수정 //
 * 
 * @RequestMapping("/guestbook/list/del") public int
 * deleteMsg(@RequestParam("gidx") int gidx ) { // 0 or 1 //
 * model.addAttribute("result", deleteService.deleteMsg(gidx));
 * 
 * // return "menu/delete"; return deleteService.deleteMsg(gidx); }
 * 
 * 수정
 * 
 * @RequestMapping(value = "/guestbook/edit", method = RequestMethod.GET) public
 * String editForm(@RequestParam("gidx") int gidx, Model model) {
 * model.addAttribute("guestbook", editService.getMsg(gidx));
 * 
 * return "menu/editForm"; }
 * 
 * 
 * // 방명록 수정 폼 2021.2.19 남서아 수정
 * 
 * @PostMapping("/guestbook/upload/edit") public String
 * editForm(@RequestParam("gidx") int gidx) { return "menu/editForm"; }
 * 
 * 
 * 
 * // 수정 값 전달
 * 
 * @RequestMapping(value = "/guestbook/edit") public int
 * editGuestbook(GuestbookEditRequest grequest, HttpServletRequest request,
 * Model model) { // System.out.println(editRequest); // int result =
 * editService.editGuestbook(editRequest, request); //
 * System.out.println(result); // model.addAttribute("result", result); //
 * return "menu/edit"; return editService.editGuestbook(grequest, request,
 * model); }
 * 
 * 
 * 
 * // 방명록 수정
 * 
 * @PostMapping(value = "/guestbook/edit")
 * 
 * @ResponseBody public int editGuestbook(@ModelAttribute("gidx") int gidx,
 * GuestbookEditRequest editRequest) {
 * 
 * return editService.editGuestbook(gidx, editRequest); }
 * 
 * 
 * 
 * 
 * //=======================================================
 * //=======================================================
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