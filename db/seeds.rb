
System.delete_all
System.create name: 'Billing System', row_id: 1, status: 'green'
System.create name: 'Human Resources', row_id: 1, status: 'green'
System.create name: 'Company Website', row_id: 1, status: 'green'
System.create name: 'Payroll System', row_id: 2, status: 'green'
System.create name: 'Company Network', row_id: 2, status: 'green'
System.create name: 'Company Data Centre', row_id: 2, status: 'green'

Incident.delete_all
IncidentHistory.delete_all

Role.delete_all
@role=Role.create name: 'admin', description: 'Administrator Role'

User.delete_all
@role.users.create name: 'Admin User', email: 'admin@admin.com', password: 'admin@admin.com', password_confirmation: 'admin@admin.com'
@role.users.create name: 'API User', email: 'api@admin.com', password: 'api@admin.com', password_confirmation: 'api@admin.com'

Contact.delete_all
Contact.create contact: 'me@mydomain.com', message: 'For dashboard problems please email:'
Contact.create contact: 'Bill and Ted in business support', message: 'For more information about the systems or problems reported please contact:'

Company.delete_all
Company.create name: 'Your Business'

puts 'Seed data has been loaded OK'