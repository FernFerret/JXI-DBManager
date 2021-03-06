class Table < ActiveRecord::Base
  has_many :columns
  belongs_to :database
  validates_presence_of :name, :database
  validates_uniqueness_of :name, :scope => :database_id
	
	def destroy_table(user)
		if self.database.user == user || user.permissions == "admin"
			return true
		else
			return false
		end
	end

	def edit_table(user)
		if self.database.user == user || user.permissions == "admin" || self.database.users != nil && self.database.users.include?(user)
			return true
		else
			return false
		end
	end

  def view_table(user)
    if self.database.user == user || user.permissions == "ta" || user.permissions == "admin" || self.database.users != nil && self.database.users.include?(user)
      return true
    else
      return false
    end
  end
  
  def create_dbsql
    return "CREATE TABLE " + self.name + ' (required int)'
  end
  
  def alter_dbsql
    return "ALTER TABLE " + self.name
  end
  
  def rename_table(newTableName)
    return "RENAME TABLE " + self.name + " TO " + newTableName
  end
  
  def drop_dbsql
    return "DROP TABLE " + self.name
  end
end
