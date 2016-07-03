class EmovalueOptionsController < ApplicationController
  def index
    @emovalue_option = EmovalueOption.with_user.find_by(user_id: current_user[:id])
  end

  def edit
    @emovalue_option = EmovalueOption.with_user.find_by(user_id: current_user[:id])

    if request.method.eql?("POST")
      @emovalue_option.update(
        use_take:                params[:use_take].to_i.eql?(EasySettings.models.emovalue_option.use_take.set_values.accept),
        notification_decrease:   params[:decrease],
        notification_increase:   params[:increase],
        notification_slowdown:   params[:slowdown],
        notification_regular:    params[:regular],
        notification_push_guide: params[:push_guide],
      )
      redirect_to user_emovalue_options_path,
        notice: @emovalue_option.errors.present? ? 'エラーのため編集が出来ませんでした。':'編集が完了しました。'
    end
  end
end
