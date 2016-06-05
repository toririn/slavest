module ErrorHandler

  rescue_from Exception, with: error_500

  def error_500(e)
    logger.error "error_500: #{e.message}"
    logger.error e.backtrace.join("\n")
    render json: { status: 500, message: "error" }
  end
end
