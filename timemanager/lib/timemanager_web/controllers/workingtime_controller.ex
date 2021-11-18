defmodule TimemanagerWeb.WorkingtimeController do
  use TimemanagerWeb, :controller

  alias Timemanager.WorkingTimes
  alias Timemanager.WorkingTimes.Workingtime
  alias Timemanager.Repo

  action_fallback TimemanagerWeb.FallbackController




   def show_by_one(conn, %{"user_id"=> user_id, "id" => id}) do
    workingtime = Repo.get_by!(Workingtime, id: id, user_id: user_id)
    render(conn, "show.json", workingtime: workingtime)
  end
  def show_all(conn, %{"user_id" => user_id}) do
   workingtime = WorkingTimes.get_workingtime_by_user(user_id)
  render(conn,"show_many.json", workingtime: workingtime)
  end
  def index_by_use(conn, %{"end" => _end, "start" => _start, "user_id" => user_id} = params) do
    workingtime = WorkingTimes.get_workingtime_by_end_start(params)
    render(conn, "index.json", workingtime: workingtime)
  end




  def index(conn, _params) do
    workingtimes = WorkingTimes.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end


  # def show(conn, %{"id" => id}) do
    # workingtime = WorkingTimes.get_workingtime!(id)
    # render(conn, "show.json", workingtime: workingtime)
  # end


  def create(conn, %{"workingtime" => workingtime_params}) do
    with {:ok, %Workingtime{} = workingtime} <- WorkingTimes.create_workingtime(workingtime_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end

  def create_by_user(conn, %{"user_id" => user_id, "workingtime" => workingtimes_params}) do
    with {:ok, %Workingtime{} = workingtime} <- WorkingTimes.create_workingtime(Map.merge(%{"user_id" => user_id}, workingtimes_params)) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.workingtime_path(conn, :show_all, workingtime))
      |> render("show.json", workingtime: workingtime)
    end
  end








  #def show_all(conn, %{"user_id" => user_id}) do
   # workingtime = WorkingTimes.get_workingtime!(user_id)
    #render(conn, "show.json", workingtime: workingtime)
  #end




  # def show(conn, %{"id" => id}) do
    # workingtime = WorkingTimes.get_workingtime!(id)
    # render(conn, "show.json", workingtime: workingtime)
  # end

  def update(conn, %{"id" => id, "workingtime" => workingtime_params}) do
    workingtime = WorkingTimes.get_workingtime!(id)

    with {:ok, %Workingtime{} = workingtime} <- WorkingTimes.update_workingtime(workingtime, workingtime_params) do
      render(conn, "show.json", workingtime: workingtime)
    end
  end

  def delete(conn, %{"id" => id}) do
    workingtime = WorkingTimes.get_workingtime!(id)

    with {:ok, %Workingtime{}} <- WorkingTimes.delete_workingtime(workingtime) do
      send_resp(conn, :no_content, "")
    end
  end
end
