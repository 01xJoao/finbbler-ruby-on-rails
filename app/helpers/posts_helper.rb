module PostsHelper

    def display_likes(post)
        votes = post.votes_for.up.by_type(User) # numero de likes
        return list_likers(votes) if votes.size <= 5
        count_likers(votes)
    end
    
    def liked_post(post)
        if !user_signed_in?
            return 'glyphicon-heart-empty'
        else
            return 'glyphicon-heart' if current_user.voted_for? post
                'glyphicon-heart-empty'
        end
    end
    
    private    
    
    def list_likers(votes)
        user_names = []
        unless votes.blank?
            votes.voters.each do |voter|
                #por cada utilizador que gostou do post
                user_names.push(link_to voter.user_name, profile_path(voter.user_name), class: 'user-name')
            end
            #apresentar o array no html
            user_names.to_sentence.html_safe + likes_plural(votes)
        end
    end
    
    def count_likers(votes)
        vote_count = votes.size
        vote_count.to_s + 'gostos.'
    end

    def likes_plural(votes)
        return 'gostam disto.' if votes.count > 1 
        'gosta disto.'
    end
end
