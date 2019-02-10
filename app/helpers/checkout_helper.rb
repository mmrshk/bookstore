module CheckoutHelper
  STATE = {
    active: 'active',
    done: 'done'
  }.freeze

  def step_state(current_step)
    return STATE[:active] if step_active?(current_step)

    STATE[:done] if step_done?(current_step)
  end

  def step_active?(current_step)
    current_step == step
  end

  def step_done?(current_step)
    past_step?(current_step)
  end
end
