class Permit < ActiveRecord::Base
  
  # validates on permit_steps#new
  validates_inclusion_of :addition, :in => [true], :message => "Please choose an improvement."

  # validates on permit_steps#enter_address
  validates_presence_of :owner_address, :if => :active_or_address?, :message => "Please enter a San Antonio address."
  
  # validates on permit_steps#enter_details
  validates :owner_address, :address => true, :if => :only_if_address_presence?
  validates_presence_of :owner_name, :if => :active_or_details?, :message => "Please enter home owner name."
  validates_presence_of :house_area, :if => :active_or_details?, :message => "Please enter the size of house in square feet."
  validates_numericality_of :house_area, :if => :only_if_house_presence?, :message => "Please enter the size of house in square feet."
  validates_presence_of :addition_area, :if => :active_or_details?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, :if => :only_if_addition_presence?, :message => "Please enter the size of addition in square feet."
  validates_numericality_of :addition_area, less_than: 1000, :if => :only_if_addition_presence?, :message => "Addition must be less than 1,000 Square Feet."
  validates_presence_of :ac, :if => :active_or_details?, :message => "Please select an air conditioning / heating system."
  validates_inclusion_of :contractor, :in => [true, false], :if => :active_or_details?, :message => "Please select whether you are using a contractor or not in this project."
  validates_presence_of :work_summary, :if => :active_or_details?, :message => "Please enter a work summary."
  validates_presence_of :job_cost, :if => :active_or_details?, :message => "Please enter the job cost."
  validates_numericality_of :job_cost, :if => :only_if_job_cost_presence?, :message => "Job cost must be a number."


  def active?
    status == 'active'
  end

  def active_or_address?
    status.to_s.include?('enter_address') || active?
  end

  def only_if_address_presence?
    active_or_address? && ! owner_address.blank?
  end

  def active_or_details?
    status.to_s.include?('enter_details') || active?
  end

  def only_if_addition_presence?
    active_or_details? && ! addition_area.blank?
  end

  def only_if_house_presence?
    active_or_details? && ! house_area.blank?
  end

  def only_if_job_cost_presence?
    active_or_details? && ! job_cost.blank?
  end
end
