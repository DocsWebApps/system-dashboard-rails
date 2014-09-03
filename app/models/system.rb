# == Schema Information
#
# Table name: systems
#
#  id                 :integer          not null, primary key
#  name               :string(255)
#  status             :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  row_id             :integer
#  last_incident_date :date
#

class System < ActiveRecord::Base
  # Define relationships 
  has_many :incidents, dependent: :destroy
  has_many :incident_histories, dependent: :destroy

  # Define validations
  validates :name, presence: true, uniqueness: {case_sensitive: false}, length: {maximum: 30}
  validates :row_id, presence: true
  validates :status, presence: true, length: {maximum: 5}

  # Define scopes
  scope :system_list_for_row, -> (row_id) { where("row_id=?", row_id).order(name: :asc) }

  # Define scopes
  def check_for_closed_incidents
    self.incidents.where(status: 'Closed').each do |incident|
      if (Time.now > (incident.closed_at + 24.hours))
        self.incident_histories.create hp_ref: incident.hp_ref, title: incident.title, time: incident.time , date: incident.date, status: incident.status, severity: incident.severity, description: incident.description, resolution: incident.resolution, closed_at: incident.closed_at
        self.last_incident_date=incident.closed_at.to_date
        incident.delete
      end
    end
    self.save
  end

  def set_system_status
    open_P1_count=self.incidents.where(severity: 'P1', status: 'Open').count
    open_P2_count=self.incidents.where(severity: 'P2', status: 'Open').count

    if open_P1_count> 0
      self.status='red'
    elsif open_P2_count > 0
      self.status='amber'
    else
      self.status='green'
    end
    self.save
  end
  
end