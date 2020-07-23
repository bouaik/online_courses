module CoursesHelper
    def enrollement_button(course)
        if current_user
            #logic to buy
            if course.user == current_user
                link_to "Analytics", course_path(course)
            elsif course.enrollements.where(user: current_user).any?
                link_to "You are already enrolled, keep learning", course_path(course)
            elsif course.price > 0
                link_to number_to_currency(course.price), new_course_enrollement_path(course), class: "btn btn-success"
            else
                link_to "Free", new_course_enrollement_path(course), class: "btn btn-success"
            end
        else
            #logic to show price
            link_to "check price", course_path(course), class: "btn btn-md btn-success"
        end
    end
end
