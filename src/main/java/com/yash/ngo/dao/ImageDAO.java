package com.yash.ngo.dao;

import com.yash.ngo.domain.Image;

public interface ImageDAO {
    Integer saveImage(Image image);
    Image findById(Integer imageId);
    void deleteImage(Integer imageId);
}
