package com.project.pincafe.bbs;

import java.util.List;
import lombok.Data;

@Data
public class BbsMstVO {
    private int rowCount;           // 전체 게시물의 개수 (게시판 데이터의 전체 기준)
    private List<BbsTblVO> bbsList; // 게시물의 리스트 ex. 1~5 (최대값은 rowsPerPage)
}
