module ApplicationHelper
    def truncate_feedback(feedback, length = 10)
        if feedback.length > length
          content_tag(:span, "#{feedback[0..length]}...", title: feedback)
        else
          feedback
        end
    end

    def find_user_name(user_id)
        user = User.find_by(id: user_id)
        user ? user.name : 'Unknown User'
    end

    def find_train_number(train_id)
        train = Train.find_by(id: train_id)
        train ? train.train_number : 'Unknown Train'
    end
end
