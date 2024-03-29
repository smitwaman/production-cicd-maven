// PostDAO.java
package com.yourcompany.blog.dao;

import com.yourcompany.blog.model.Post;

import java.util.ArrayList;
import java.util.List;

public class PostDAO {
    private List<Post> posts;

    public PostDAO() {
        posts = new ArrayList<>();
        // Initialize posts or load from database
    }

    public List<Post> getAllPosts() {
        return posts;
    }

    public void addPost(Post post) {
        posts.add(post);
        // Save to database
    }
}
