class Invitational
  include Virtus.model

  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_reader :user, :parent_object

  attribute :email, String
  attribute :name, String
  attribute :type, String
  attribute :type_id, Integer

  ALLOWED_TYPES = %w(Project Invoice Staff Job)

  validates :type, inclusion: ALLOWED_TYPES
  validates :name, :email, :type, :type_id, presence: true
  validates :email, format: { :with => %r{.+@.+\..+} }, allow_blank: true

  def save
    return false unless valid?

    unless @user = User.find_by_email(email)
      create_user
    else
      send_invitational_email(type)
    end
    # delegates_errors_to_user unless @user.valid?

    if !errors.any?
      connect_invitational
      true
    else
      false
    end
  end

  def persisted?
    false
  end

  private
    def create_user
      @user = User.invite! email: email, role: "business" if ["Project", "Invoice"].include? type
      @user = User.invite! email: email, role: "employee" if ["Staff", "Job"].include? type
    end

    def send_invitational_email(type)
    end

    # def delegates_errors_to_user
    #   errors.add(:email, @user.errors[:email].first) if @user.errors[:email].present?
    #   errors.add(:name, @user.errors[:name].first) if @user.errors[:name].present?
    # end

    def connect_invitational
      case type
      when "Project"
        @project = Project.find(type_id)
        @project.users << @user
        @user.create_account! business_type: "business", name: name
        @user.save!
        # send future Project invitational mailer
      when "Invoice"
        @invoice = Invoice.find(type_id)
        @user.create_account! business_type: "business", name: name
        @user.save!
        @invoice.update_attributes(reciever_id: @user.account_id)
        # send future Invoice invitational mailer
      when "Staff"
        @staffer = User.find(type_id)
        @staffer.add_staffer!(@user)
        # send future Staffer Invitational mailer
      when "Job"
        @job = Job.find(type_id)
        # send future Job Staffer Invitational mailer
      end
    end
end