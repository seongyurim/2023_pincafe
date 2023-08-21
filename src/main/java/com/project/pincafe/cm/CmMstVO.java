package com.project.pincafe.cm;

import java.util.List;
import lombok.Data;

@Data
public class CmMstVO {
    private int rowCount;             // 게시물의 전체 개수
    private List<CmTblVO> cmList;     // 게시물의 리스트
    
}
