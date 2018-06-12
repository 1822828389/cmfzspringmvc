package com.baizhi.daos;

import com.baizhi.entity.Cmfzlog;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CmfzlogDao {

    int insert(Cmfzlog cmfzlog);

    List<Cmfzlog> selectAll();

    List<Cmfzlog> queryByPage(@Param("start") Integer start, @Param("end") Integer end);

    Integer querySize();

}