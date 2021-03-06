class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    self.joins(boats: :classifications).where("classifications.name = ?", "Catamaran")
  end

  def self.sailors
    self.joins(boats: :classifications).where("classifications.name = ?", "Sailboat").uniq
  end

  def self.motorboats
    self.joins(boats: :classifications).where("classifications.name = ?", "Motorboat").uniq
  end

  def self.talented_seamen
    self.where(:id => sailors.map(&:id)).where(:id => motorboats.map(&:id))
  end

  def self.non_sailors
    self.where.not(:id => sailors.map(&:id))
  end
end
