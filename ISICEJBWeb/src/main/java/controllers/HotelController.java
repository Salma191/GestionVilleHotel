package controllers;

import java.io.IOException;
import java.util.List;

import dao.IDaoLocale;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.EJB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import entities.Hotel;
import entities.Ville;

public class HotelController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@EJB(beanName = "salma")
	private IDaoLocale<Hotel> ejb;
	@EJB(beanName = "kenza")
	private IDaoLocale<Ville> villeService;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public HotelController() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		List<Ville> villes = villeService.findAll();

		String action = request.getParameter("action");
		String nom = request.getParameter("nom");
		String adresse = request.getParameter("adresse");
		String telephone = request.getParameter("telephone");
		String villeSelected = request.getParameter("ville");

		if (villeSelected != null && !villeSelected.isEmpty()) {
			int villeId = Integer.parseInt(villeSelected);
			Ville selectedVille = villeService.findById(villeId);
			ejb.create(new Hotel(nom, adresse, telephone, selectedVille));
		} else {
		}

		request.setAttribute("villes", villeService.findAll());

		if (action != null) {
			switch (action) {

			case "delete":
				int idToDelete = Integer.parseInt(request.getParameter("id"));
				Hotel hotelToDelete = ejb.findById(idToDelete);
				ejb.delete(hotelToDelete);
				break;
			case "update":
				String idToUpdateParam = request.getParameter("idHotel");
				if (idToUpdateParam != null && !idToUpdateParam.isEmpty()) {
					int idToUpdate = Integer.parseInt(idToUpdateParam);
					Hotel hotelToUpdate = ejb.findById(idToUpdate);

					if (hotelToUpdate != null) {
						// Récupérez les nouveaux champs à partir des paramètres de la requête
						String nouveauNom = request.getParameter("nom");
						String nouvelleAdresse = request.getParameter("adresse");
						String nouveauTelephone = request.getParameter("telephone");

						String villeIdParam = request.getParameter("villeId");
						int nouvelleVilleId = (villeIdParam != null && !villeIdParam.isEmpty())? Integer.parseInt(villeIdParam): -1;

						// Mettez à jour les propriétés de l'entité Hotel
						hotelToUpdate.setNom(nouveauNom);
						hotelToUpdate.setAdresse(nouvelleAdresse);
						hotelToUpdate.setTelephone(nouveauTelephone);

						// Chargez la nouvelle Ville associée à l'Hotel
						if (nouvelleVilleId != -1) {
							Ville nouvelleVille = villeService.findById(nouvelleVilleId);
							hotelToUpdate.setVille(nouvelleVille);
						} else {
							System.out.println("la Ville est nulle ou introuvable");
						}

						ejb.update(hotelToUpdate);

						// Redirigez vers la page appropriée après la mise à jour
						response.sendRedirect("HotelController");
					} else {
						System.out.println("Aucun hôtel trouvé avec l'ID : " + idToUpdate);
					}
				} 
				break;

		
			}

		request.setAttribute("hotels", ejb.findAll());
		RequestDispatcher dispatcher = request.getRequestDispatcher("hotel.jsp");
		dispatcher.forward(request, response) ;
	}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}
}