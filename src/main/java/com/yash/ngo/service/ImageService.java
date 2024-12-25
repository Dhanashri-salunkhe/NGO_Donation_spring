package com.yash.ngo.service;

import com.yash.ngo.dao.ImageDAO;
import com.yash.ngo.domain.Image;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ImageService {
    @Autowired
    private ImageDAO imageDao;

    public void saveImage(Image image) {
        imageDao.saveImage(image);
    }

    //public Image getImage(Long id) {
        //return imageDao.getImage(id);
    //}
}
