import axios from 'axios';
import { API_URL } from '../config/constants.config';

class ClockService {
  create(userID, body) {
    return axios.post(`${API_URL}/clocks/${userID}`, {
      'clock': {
        'time': body.time,
        'status': body.status
      }
    });
  }

  findAll(userID) {
    return axios.get(`${API_URL}/clocks/${userID}`);
  }
}

export default new ClockService();