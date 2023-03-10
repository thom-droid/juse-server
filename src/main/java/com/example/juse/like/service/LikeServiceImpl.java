package com.example.juse.like.service;

import com.example.juse.like.entity.Like;
import com.example.juse.like.repository.LikeRepository;
import com.example.juse.user.entity.User;
import com.example.juse.user.repository.UserRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.Optional;

@RequiredArgsConstructor
@Service
public class LikeServiceImpl implements LikeService {

    private final LikeRepository likeRepository;

    private final UserRepository userRepository;

    @Override
    public Like create(long whoLikes, long whoIsLiked) {
        User whoLike = userRepository.findById(whoLikes).orElseThrow();
        User whoIsLike = userRepository.findById(whoIsLiked).orElseThrow();

        Like findLike = findWhoLikesIdAndWhoIsLikedLike(whoLikes, whoIsLiked);

        if (findLike.getId() != null && whoLikes == findLike.getWhoLikes().getId() && whoIsLiked == findLike.getWhoIsLiked().getId()) {
            delete(whoLikes, whoIsLiked);
            return null;
        }
        else {

            Like like = Like.builder()
                    .whoLikes(whoLike)
                    .whoIsLiked(whoIsLike)
                    .build();

            //
            int liked = whoIsLike.getLiked();
            whoIsLike.setLiked(++liked);


            return likeRepository.save(like);
        }
    }

    @Override
    public void delete(long whoLikes, long whoIsLiked) {
        User whoLike = userRepository.findById(whoLikes).orElseThrow();
        User whoIsLike = userRepository.findById(whoIsLiked).orElseThrow();

        Like like = likeRepository.findByWhoLikesIdAndWhoIsLikedId(whoLikes, whoIsLiked).orElseThrow();
        int liked = whoIsLike.getLiked();

        whoIsLike.setLiked(--liked);

        likeRepository.delete(like);
    }

    public Like findWhoLikesIdAndWhoIsLikedLike(long whoLikes, long whoIsLiked) {
        Optional<Like> optionalLike = likeRepository.findByWhoLikesIdAndWhoIsLikedId(whoLikes, whoIsLiked);

        Like like = optionalLike.orElseGet(() -> new Like());

        return like;
    }


}
