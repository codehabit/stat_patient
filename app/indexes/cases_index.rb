class CasesIndex < Chewy::Index
  define_type Case.includes(:messages) do
    field :id
    field :subject
    field :last_reply_by, value: ->(rcase) {rcase.messages.order("created_at DESC").first.sender.full_name}
    field :started_by, value: ->(rcase) {rcase.originator.full_name}
    field :last_replied_on, value: ->(rcase) {rcase.messages.order("created_at DESC").first.created_at.strftime("%b %d, %l:%M %p")}
  end
end

