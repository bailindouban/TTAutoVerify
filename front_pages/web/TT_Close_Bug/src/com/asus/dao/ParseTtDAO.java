package com.asus.dao;

import java.util.List;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * ParseTt entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.asus.dao.ParseTt
 * @author MyEclipse Persistence Tools
 */
public class ParseTtDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory.getLogger(ParseTtDAO.class);
	// property constants
	public static final String BUG_ID = "bugId";
	public static final String DEVICE = "device";

	public void save(ParseTt transientInstance) {
		log.debug("saving ParseTt instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(ParseTt persistentInstance) {
		log.debug("deleting ParseTt instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public ParseTt findById(java.lang.Integer id) {
		log.debug("getting ParseTt instance with id: " + id);
		try {
			ParseTt instance = (ParseTt) getSession().get(
					"com.asus.dao.ParseTt", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(ParseTt instance) {
		log.debug("finding ParseTt instance by example");
		try {
			List results = getSession().createCriteria("com.asus.dao.ParseTt")
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
		log.debug("finding ParseTt instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from ParseTt as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByBugId(Object bugId) {
		return findByProperty(BUG_ID, bugId);
	}

	public List findByDevice(Object device) {
		return findByProperty(DEVICE, device);
	}

	public List findAll() {
		log.debug("finding all ParseTt instances");
		try {
			String queryString = "from ParseTt";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public ParseTt merge(ParseTt detachedInstance) {
		log.debug("merging ParseTt instance");
		try {
			ParseTt result = (ParseTt) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(ParseTt instance) {
		log.debug("attaching dirty ParseTt instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(ParseTt instance) {
		log.debug("attaching clean ParseTt instance");
		try {
			getSession().buildLockRequest(LockOptions.NONE).lock(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}