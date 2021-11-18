import axios from 'axios';
import { API_URL } from '../config/constants.config';

class WorkingTimeService {
  create(userID, body) {
    return axios.post(`${API_URL}/workingtimes/${userID}`, {
      'workingtime': {
        'start': body.start,
        'end': body.end
      }
    });
  }

  update(id, body) {
    return axios.put(`${API_URL}/workingtimes/${id}`, {
      'workingtime': {
        'start': body.start,
        'end': body.end
      }
    });
  }

  findAll(userID) {
    return axios.get(`${API_URL}/workingtimes/${userID}`);
  }

  findOne(userID, id) {
    return axios.get(`${API_URL}/workingtimes/${userID}/${id}`);
  }

  delete(id) {
    return axios.delete(`${API_URL}/workingtimes/${id}`);
  }
}

export default new WorkingTimeService();