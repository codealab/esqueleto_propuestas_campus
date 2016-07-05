class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.all
    # render 'proposals/index.html.erb'
  end
  def new
    @proposal = Proposal.new
    # render 'proposal/new.html.erb'
  end
  
  def create
   proposal = Proposal.find_by(name: params[:proposal][:name])
   if proposal == nil
     @proposal = Proposal.create(proposal_params)
     flash[:success] = "Propuesta Agregada"
   else
     flash[:danger] = "No puedes duplicar una propuesta"
   end
   redirect_to proposals_path
  end
  
  def show
    @proposal = Proposal.find(params[:id])
    @counter = @proposal.counter_codea.body
    # render 'proposals/show.html.erb'
  end
  
  def edit
    @proposal = Proposal.find(params[:id])
    # render 'proposals/edit.html.erb'
  end
  
  def update
    @proposal = Proposal.find(params[:id])
    @proposal.update(proposal_params)
    flash[:success] = "Propuesta actualizada"
    redirect_to proposal_path
  end
  
  def destroy
    @proposal = Proposal.find(params[:id])
    @proposal.destroy
    flash[:danger] = "Propuesta borrada"
    redirect_to proposals_path
  end

  private

    def proposal_params
      params.require(:proposal).permit(:name, :avatar)
    end
end
