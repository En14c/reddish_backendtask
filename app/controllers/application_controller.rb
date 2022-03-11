class ApplicationController < ActionController::API
    rescue_from ::ActiveRecord::RecordNotFound, with: :record_not_found_error
    rescue_from ::ActiveRecord::NotNullViolation, with: :not_null_violation_error
    rescue_from ::NameError, with: :name_error
    rescue_from ::NoMethodError, with: :no_method_error

    protected

    def record_not_found_error(exception)
        render json: {error: exception.message}.to_json, status: 400
    end

    def name_error(exception)
        render json: {error: exception.message}.to_json, status: 400
    end

    def no_method_error(exception)
        render json: {error: exception.message}.to_json, status: 400
    end
    
    def not_null_violation_error(exception)
        render json: {error: exception.message}.to_json, status: 400
    end
end
