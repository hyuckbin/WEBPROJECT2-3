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
            stmt = conn.prepareStatement(BOARD_INSERT);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            return stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 자원 해제 코드가 들어가야 함 (JDBCUtil.close(stmt, conn) 등)
            JDBCUtil.close(conn);
        }
        return 0;
    }

    // 2. 글 목록 조회 (Read List)
    public List<BoardVO> getBoardList() {
        System.out.println("===> JDBC로 getBoardList() 기능 처리");
        List<BoardVO> boardList = new ArrayList<BoardVO>();
        try {
            conn = JDBCUtil.getConnection();
            stmt = conn.prepareStatement(BOARD_LIST);
            rs = stmt.executeQuery();
            while (rs.next()) {
                BoardVO board = new BoardVO();
                board.setSeq(rs.getInt("seq"));
                board.setTitle(rs.getString("title"));
                board.setWriter(rs.getString("writer"));
                board.setContent(rs.getString("content"));
                board.setRegdate(rs.getDate("regdate"));
                board.setCnt(rs.getInt("cnt"));
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
            stmt = conn.prepareStatement(BOARD_UPDATE);
            stmt.setString(1, vo.getTitle());
            stmt.setString(2, vo.getWriter());
            stmt.setString(3, vo.getContent());
            stmt.setInt(4, vo.getSeq());
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
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            JDBCUtil.close(rs, stmt, conn);
        }
        return board;
    }
}