/*
 * package com.gnjk.peeps.guestbook;
 * 
 * import javax.servlet.http.HttpServletRequest;
 * 
 * import org.springframework.beans.factory.annotation.Autowired; import
 * org.springframework.stereotype.Controller; import
 * org.springframework.ui.Model; import
 * org.springframework.web.bind.annotation.RequestMapping; import
 * org.springframework.web.bind.annotation.RequestMethod; import
 * org.springframework.web.bind.annotation.RequestParam;
 * 
 * import com.gnjk.peeps.guestbook.domain.GuestbookEditRequest; import
 * com.gnjk.peeps.guestbook.service.GuestbookEditService;
 * 
 * @Controller
 * 
 * @RequestMapping("/guestbook/edit") public class GuestbookEditController {
 * 
 * @Autowired private GuestbookEditService editService;
 * 
 * 
 * @RequestMapping(method = RequestMethod.GET) public String
 * editForm(@RequestParam("gidx") int gidx ,Model model) {
 * model.addAttribute("guestbook",editService.getMsg(gidx));
 * 
 * return "menu/editForm";
 * 
 * }
 * 
 * @RequestMapping(method =RequestMethod.POST) public String
 * editGuestbook(GuestbookEditRequest editRequest,HttpServletRequest
 * request,Model model){ System.out.println(editRequest); int
 * result=editService.editGuestbook(editRequest, request);
 * System.out.println(result); model.addAttribute("result", result);
 * 
 * return "menu/edit"; } }
 */