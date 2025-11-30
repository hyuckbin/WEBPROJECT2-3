package org.example.com.crud.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import org.example.com.crud.bean.BoardVO;
import org.example.com.crud.common.JDBCUtil;

public class BoardDAO {

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    // SQL 명령어 상수 정의
    private final String BOARD_INSERT = "insert into BOARD (title, writer, content) values (?,?,?)";
    private final String BOARD_UPDATE = "update BOARD set title=?, writer=?, content=? where seq=?";
    private final String BOARD_DELETE = "delete from BOARD where seq=?";
    private final String BOARD_GET = "select * from BOARD where seq=?";
    private final String BOARD_LIST = "select * from BOARD order by seq desc";

    // 1. 글 추가 (Create)
    public int insertBoard(BoardVO vo) {
        System.out.println("===> JDBC로 insertBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            String sql = "insert into BOARD (title, writer, content, filename) values (?,?,?,?)";
            stmt = conn.prepareStatement(sql);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setString(4, vo.getFilename());
            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt,conn);
        }
        return 0;
    }

    // 2. 글 목록 조회 (Read List)
    public List<BoardVO> getBoardList(String key, String word) {
        System.out.println("===> JDBC로 getBoardList() 기능 처리");
        List<BoardVO> boardList = new ArrayList<BoardVO>();
        try {
            conn = JDBCUtil.getConnection();
            String sql = "select * from BOARD order by seq desc";

        if(word!= null && !word.equals("")){
            sql = "select * from BOARD where "+key+" like '%"+word+"%' order by seq desc";
        }
            stmt = conn.prepareStatement(sql);
            rs = stmt.executeQuery();

            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setSeq(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setRegdate(rs.getDate("regdate"));
                board.setCnt(rs.getInt("cnt"));
                board.setFilename(rs.getString("filename"));
                boardList.add(board);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(conn);
        }
        return boardList;
    }

    // 3. 글 삭제 (Delete)
    public void deleteBoard(BoardVO vo) {
        System.out.println("===> JDBC로 deleteBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_DELETE);
            stmt.setInt(1, vo.getSeq());
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
    }

    // 4. 글 수정 (Update)
    public int updateBoard(BoardVO vo) {
        System.out.println("===> JDBC로 updateBoard() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            String sql = "";
            // 1. 새 파일이 업로드되었는지 확인
            if (vo.getFilename() != null && !vo.getFilename().equals("")) {
                sql = "update BOARD set title=?, writer=?, content=?, filename=? where seq=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, vo.getTitle());
                stmt.setString(2, vo.getWriter());
                stmt.setString(3, vo.getContent());
                stmt.setString(4, vo.getFilename());
                stmt.setInt(5, vo.getSeq());
            } else {
                sql = "update BOARD set title=?, writer=?, content=? where seq=?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, vo.getTitle());
                stmt.setString(2, vo.getWriter());
                stmt.setString(3, vo.getContent());
                stmt.setInt(4, vo.getSeq());
            }

            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
        return 0;
    }

    // 5. 글 상세 조회
    public BoardVO getBoard(int seq) {
        System.out.println("===> JDBC로 getBoard() 기능 처리");
        BoardVO board = null;
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_GET);
            stmt.setInt(1, seq);
            rs = stmt.executeQuery();
            if (rs.next()) {
                board = new BoardVO();
                board.setSeq(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setRegdate(rs.getDate("regdate"));
                board.setCnt(rs.getInt("cnt"));
                board.setFilename(rs.getString("filename"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return board;
    }

    // 조회수 증가 (상세보기 시 호출)
    public void increaseCnt(int seq) {
        System.out.println("===> JDBC로 increaseCnt() 기능 처리");
        try {
            conn = JDBCUtil.getConnection();
            // 해당 글 번호(seq)의 조회수(cnt)를 기존 값에서 +1 더해서 수정
            String sql = "UPDATE BOARD SET cnt = cnt + 1 WHERE seq = ?";
            stmt = conn.prepareStatement(sql);
            stmt.setInt(1, seq);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(stmt, conn);
        }
    }
}