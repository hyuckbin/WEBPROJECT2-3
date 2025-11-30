package org.example.com.crud.common;

import java.io.File;
import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import org.example.com.crud.bean.BoardVO;
import org.example.com.crud.dao.BoardDAO;

public class FileUpload {
    public BoardVO uploadPhoto(HttpServletRequest request) {
        String filename = "";
        int sizeLimit = 15 * 1024 * 1024; // 파일 크기 제한 (15MB)

        // 실제로 서버에 저장될 경로를 구합니다.
        String realPath = request.getServletContext().getRealPath("upload");

        // 만약 upload 폴더가 없으면 생성합니다.
        File dir = new File(realPath);
        if (!dir.exists()) dir.mkdirs();

        BoardVO one = null;
        MultipartRequest multipartRequest = null;

        try {
            // 파일이 서버(realPath)에 저장
            multipartRequest = new MultipartRequest(request, realPath,
                    sizeLimit, "utf-8", new DefaultFileRenamePolicy());

            String title = multipartRequest.getParameter("title");
            String writer = multipartRequest.getParameter("writer");
            String content = multipartRequest.getParameter("content");

            // 업로드된 파일의 이름을 가져옵니다.
            filename = multipartRequest.getFilesystemName("photo"); // JSP의 input name="photo"

            one = new BoardVO();
            one.setTitle(title);
            one.setWriter(writer);
            one.setContent(content);
            one.setFilename(filename); // 파일명 VO에 담기

            // seq가 있다면(수정할 때) 받아옴
            String seq = multipartRequest.getParameter("seq");
            if (seq != null && !seq.equals("")) {
                one.setSeq(Integer.parseInt(seq));
            }

        } catch (IOException e) {
            e.printStackTrace();
        }

        return one; // 데이터가 담긴 VO 객체 반환
    }

    // 파일 삭제 기능 (글 삭제/수정 시 사용)
    public static void deleteFile(HttpServletRequest request, String filename) {
        String realPath = request.getServletContext().getRealPath("upload");
        File f = new File(realPath + "/" + filename);
        if(f.exists()) f.delete();
    }
}
