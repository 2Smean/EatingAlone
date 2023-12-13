package semi.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import naver.storage.NcpObjectStorageService;
import semi.dao.MarketBoardDao;
import semi.dto.BoardDto;
import semi.dto.BoardFileDto;
import semi.dto.MarketBoardDto;
import semi.dto.RecipeDto;
import semi.service.BoardFileService;
import semi.service.BoardService;
import semi.service.MarketBoardService;


@Controller
public class MarketBoardController {
	@Autowired
	private MarketBoardService marketBoardService;
	@Autowired NcpObjectStorageService storageService;
	@Autowired private MarketBoardDao marketBoardDao;
	
	
	 @GetMapping("/mboard")
	 public String boardList() {
		 return "market/marketboardlist";
	 }
	 
	 @GetMapping("/mboardform")
	 public String boardForm() {
		 return "market/marketboardform";
	 }
	
	 
	 @PostMapping("/mboard/insertMarketBoard")
	    public String insertMarketBoard(@ModelAttribute MarketBoardDto dto, HttpServletRequest request, HttpSession session, @RequestParam MultipartFile upload) {
	        String photo=storageService.uploadFile(NcpObjectStorageService.STORAGE_EATINGALONE,
	                NcpObjectStorageService.DIR_PHOTO, upload);

	        dto.setSBoardImage(photo);
	        marketBoardService.insertMarketBoard(dto);

	        return "redirect:../";
	    }
		

		
		
	
		
		
	 


		//새글일때/답글일때 모두 호출
		@GetMapping("/mboard/form")
		public String form(
				Model model,
				/*새글일경우 값이 안넘어오므로 defaultValue 값이 적용된다*/
				@RequestParam(defaultValue = "1") int currentPage,
				@RequestParam(defaultValue = "0") int num
				
				)
		{
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("num", num);

			return "market/marketboardform";
		}

		
		//새글/답글 저장
		/*
		 * @PostMapping("/mboard/addboard") public String addBoard(
		 * 
		 * @ModelAttribute MarketBoardDto dto,
		 * 
		 * @RequestParam int currentPage,
		 * 
		 * @RequestParam List<MultipartFile> upload, HttpServletRequest request,
		 * HttpSession session ) {
		 */
			//파일 업로드할 경로
			//String path=request.getSession().getServletContext().getRealPath("/resources/upload");
			
			/*
			//db 에 저장할 로그인정보
			String myid=(String)session.getAttribute("myid");
			String writer=(String)session.getAttribute("myname");
			//dto에 넣기
			dto.setMyid(myid);
			dto.setWriter(writer);

			//일단 BoardDto 먼저 저장
			marketBoardService.insertBoard(dto);
			//selectKey : num 값 넘어왔는지 확인
			System.out.println("num="+dto.getNum());
			*/


			//사진들 업로드
			//사진 업로드를 안했을경우 리스트의 첫데이타의 파일명이 빈문자열이 된다
			//즉 업로드했을경우에만 db 에 저장을 한다
//			if(!upload.get(0).getOriginalFilename().equals("")) {
//				for(MultipartFile multi:upload)
//				{
//					//랜덤 파일명 생성
//					String fileName=UUID.randomUUID().toString();
//					//업로드
//					try {
//						multi.transferTo(new File(path+"/"+fileName));
//						//파일은 따로 db 에 insert 한다
//						MarketProductDto fdto=new MarketProductDto();
//						fdto.setNBoardSeq(dto.getNBoardSeq());//boarddb 에 방금 insert 된 num값
//						fdto.setSProductImage1(fileName);
//
//						marketProductService.insertProductImage(fdto);
//
//					} catch (IllegalStateException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					} catch (IOException e) {
//						// TODO Auto-generated catch block
//						e.printStackTrace();
//					}
//				}
//			}

			//새글인경우는 1페이지로, 답글인경우는 보던 페이지로 이동한다
//			return "redirect:list?currentPage="+currentPage;
//		}
//
//		@GetMapping("/mboard/content")
//		public String getContent(Model model,@RequestParam int nBoardSeq,@RequestParam(defaultValue = "1") int currentPage)
//		{
//			//조회수 증가
//			marketBoardService.updateReadCount(nBoardSeq);
//			//num 에 해당하는 dto 얻기
//			MarketBoardDto dto=marketBoardService.getData(nBoardSeq);
//			                                   
//			/*
//			//프로필 사진 가져오기
//			String profile_photo=memberDao.getData(dto.getMyid()).getPhoto();
//			*/
//			
//			/*
//			//사진과 사진 갯수
//			List<String> photos=marketProductService.getProductImageByNBoardSeq(nBoardSeq);
//			dto.setPhotocount(photos.size());//사진갯수
//			dto.setSBoardImage(photos);//사진 파일명들
//			*/
//	
//			//model 에 저장
//			//model.addAttribute("profile_photo", profile_photo);
//			model.addAttribute("dto", dto);
//			model.addAttribute("currentPage",currentPage);		
//	
//			return "market/content";
//		}
	
//		@GetMapping("/mboard/delete")
//		public String deleteBoard(@RequestParam int nBoardSeq,@RequestParam int currentPage)
//		{
//			//삭제
//			marketBoardService.deleteMarketBoard(nBoardSeq);
//	
//			return "redirect:./list?currentPage="+currentPage;
//		}
	
		/*
		 * @GetMapping("/board/updateform") public String updateForm(Model
		 * model,@RequestParam int nBoardSeq,@RequestParam int currentPage) {
		 * MarketBoardDto dto=marketBoardService.getData(nBoardSeq);
		 * List<MarketProductDto>
		 * flist=marketProductService.getFileDataByNBoardSeq(nBoardSeq);
		 * 
		 * model.addAttribute("currentPage", currentPage); model.addAttribute("dto",
		 * dto); model.addAttribute("flist", flist);
		 * 
		 * return "market/updateform"; }
		 */

}

