package com.asus.dao;

import java.util.List;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * ClosedBug entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.asus.dao.ClosedBug
 * @author MyEclipse Persistence Tools
 */
public class ClosedBugDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(ClosedBugDAO.class);
	// property constants
	public static final String CLOSED_BUG = "closedBug";

	public void save(ClosedBug transientInstance) {
		log.debug("saving ClosedBug instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(ClosedBug persistentInstance) {
		log.debug("deleting ClosedBug instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public ClosedBug findById(java.lang.Integer id) {
		log.debug("getting ClosedBug instance with id: " + id);
		try {
			ClosedBug instance = (ClosedBug) getSession().get(
					"com.asus.dao.ClosedBug", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(ClosedBug instance) {
		log.debug("finding ClosedBug instance by example");
		try {
			List results = getSession()
					.createCriteria("com.asus.dao.ClosedBug")
					.add(Example.create(instance)).list();
			log.debug("find by example successful, result size: "
					+ results.size());
			return results;
		} catch (RuntimeException re) {
			log.error("find by example failed", re);
			throw re;
		}
	}

	public List findByProperty(String propertyName, Object value) {
		log.debug("finding ClosedBug instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from ClosedBug as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByClosedBug(Object closedBug) {
		return findByProperty(CLOSED_BUG, closedBug);
	}

	public List findAll() {
		log.debug("finding all ClosedBug instances");
		try {
			String queryString = "from ClosedBug";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public ClosedBug merge(ClosedBug detachedInstance) {
		log.debug("merging ClosedBug instance");
		try {
			ClosedBug result = (ClosedBug) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(ClosedBug instance) {
		log.debug("attaching dirty ClosedBug instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(ClosedBug instance) {
		log.debug("attaching clean ClosedBug instance");
		try {
			getSession().buildLockRequest(LockOptions.NONE).lock(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}