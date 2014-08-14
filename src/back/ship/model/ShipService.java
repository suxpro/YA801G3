package back.ship.model;

import java.util.List;
import java.util.Map;

public class ShipService {

	private ShipDAO dao;

	public ShipService() {
		dao = new ShipDAO();
	}

	
	public List<ShipVO> getAll(Map<String, String[]> map) {
		return dao.getAll(map);
	}
}
