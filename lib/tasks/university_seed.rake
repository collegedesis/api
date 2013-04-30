task :make_universities => :environment do
  Organization.all.each do |org|
    uni = University.find_or_create_by_name_and_state(name:org.university, state:org.state)
    org.update_attributes(university_id: uni.id) if uni
  end
end