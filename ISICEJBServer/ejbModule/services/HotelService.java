package services;

import java.util.List;

import dao.IDaoLocale;
import dao.IDaoRemote;
import entities.Hotel;
import entities.Ville;
import entities.Hotel;
import jakarta.annotation.security.PermitAll;
import jakarta.ejb.Stateless;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.persistence.Query;

@Stateless(name = "salma")
public class HotelService implements IDaoRemote<Hotel>, IDaoLocale<Hotel> {
	@PersistenceContext
	private EntityManager em;

	@Override
	@PermitAll
	public Hotel create(Hotel o) {
		em.persist(o);
		return o;
	}

	@Override
	@PermitAll
	public boolean delete(Hotel o) {
		if (o != null) {
			// Check if the entity is managed before trying to remove it
			if (em.contains(o)) {
				em.remove(o);
			} else {
				// If the entity is detached, merge it first and then remove
				Hotel managedEntity = em.merge(o);
				em.remove(managedEntity);
			}
			return true;
		}
		return false;
	}

	@Override
	@PermitAll
	public Hotel update(Hotel o) {
		Hotel existingHotel = em.find(Hotel.class, o.getId());

		if (existingHotel != null) {
			existingHotel.setNom(o.getNom());
			existingHotel.setAdresse(o.getAdresse());
			existingHotel.setTelephone(o.getTelephone());
			existingHotel.setVille(o.getVille());


			em.merge(existingHotel);
		}

		return o;
	}

	@Override
	@PermitAll
	public Hotel findById(int id) {
		// TODO Auto-generated method stub
		return em.find(Hotel.class, id);
	}

	@Override
	@PermitAll
	public List<Hotel> findAll() {
		Query query = em.createQuery("select h from Hotel h");
		return query.getResultList();
	}
	
	@PermitAll
	public List<Ville> findVilles() {
	    Query query = em.createQuery("SELECT v FROM Ville v");
	    return query.getResultList();
	}

	@Override
	public List<Hotel> findByVille(int villeId) {
		 Query query = em.createQuery("SELECT h FROM Hotel h WHERE h.ville.id = :villeId");
		    query.setParameter("villeId", villeId);
		    return query.getResultList();
	}

	
}
