class KnowledgeEntriesController < ApplicationController
  def index
    @knowledge_entries = KnowledgeEntry.recent
    @tags = Tag.find(:all)
  end

  def new
    @knowledge_entry = KnowledgeEntry.new
  end

  def create

    tags = params[:knowledge_entry].delete(:tags)

    @knowledge_entry = KnowledgeEntry.new(params[:knowledge_entry])
    @knowledge_entry.tag_list = tags

    if !@knowledge_entry.save
      render :action => "new"
    else
      flash[:notice] = "knowledge successfully created!"
      redirect_to "/"
    end
  end

  def edit
    @knowledge_entry = KnowledgeEntry.find(params[:id])
  end

  def update
    @knowledge_entry = KnowledgeEntry.find(params[:id])
    @knowledge_entry.tag_list = params[:knowledge_entry][:tags]

    if @knowledge_entry.save

      params[:knowledge_entry].delete(:tags)

      if @knowledge_entry.update_attributes(params[:knowledge_entry])
        flash[:notice] = "knowledge successfully updated!"
        redirect_to "/"
      else
        render :action => "edit"
      end
    else
      render :action => "edit"
    end
  end

  def delete
    knowledge_entry = KnowledgeEntry.find(params[:id])
    if knowledge_entry.destroy
      flash[:notice] = "knowledge successfully deleted!"
      redirect_to "/"
    end
  end

  def tag

    @knowledge_entries = KnowledgeEntry.tagged_with(Tag.find(params[:tag]), :on => :tags)
    @tags = Tag.find(:all)

    render :action => 'index'
  end

end
