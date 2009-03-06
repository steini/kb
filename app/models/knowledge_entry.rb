class KnowledgeEntry < ActiveRecord::Base

  validates_presence_of :title, :content

  acts_as_taggable_on :tags

  named_scope :recent, {
    :limit => 15,
    :order => 'created_at DESC'
  }

  define_index do
    indexes title
    indexes content
    
    has created_at
  end

  def after_destroy()
    check_taggings
  end

  def after_save
    check_taggings
  end

  def check_taggings

    Tag.find(:all).each do |tag|
      if KnowledgeEntry.tagged_with(tag, :on => :tags).size == 0
        tag.destroy
      end
    end
  end

end
