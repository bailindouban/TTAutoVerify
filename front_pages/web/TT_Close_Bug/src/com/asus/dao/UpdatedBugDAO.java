package com.asus.dao;

import java.util.List;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * UpdatedBug entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.asus.dao.UpdatedBug
 * @author MyEclipse Persistence Tools
 */
public class UpdatedBugDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(UpdatedBugDAO.class);
	// property constants
	public static final String TT_BUG = "ttBug";
	public static final String TAG = "tag";
	public static final String APK_VERSION = "apkVersion";
	public static final String CHANGE_LINK = "changeLink";
	public static final String DEVICE = "device";
	public static final String BRANCH = "branch";

	public void save(UpdatedBug transientInstance) {
		log.debug("saving UpdatedBug instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(UpdatedBug persistentInstance) {
		log.debug("deleting UpdatedBug instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public UpdatedBug findById(java.lang.Integer id) {
		log.debug("getting UpdatedBug instance with id: " + id);
		try {
			UpdatedBug instance = (UpdatedBug) getSession().get(
					"com.asus.dao.UpdatedBug", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(UpdatedBug instance) {
		log.debug("finding UpdatedBug instance by example");
		try {
			List results = getSession()
					.createCriteria("com.asus.dao.UpdatedBug")
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
		log.debug("finding UpdatedBug instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from UpdatedBug as model where model."
					+ propertyName + "= ?";
			Query queryObject = getSession().createQuery(queryString);
			queryObject.setParameter(0, value);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find by property name failed", re);
			throw re;
		}
	}

	public List findByTtBug(Object ttBug) {
		return findByProperty(TT_BUG, ttBug);
	}

	public List findByTag(Object tag) {
		return findByProperty(TAG, tag);
	}

	public List findByApkVersion(Object apkVersion) {
		return findByProperty(APK_VERSION, apkVersion);
	}

	public List findByChangeLink(Object changeLink) {
		return findByProperty(CHANGE_LINK, changeLink);
	}

	public List findByDevice(Object device) {
		return findByProperty(DEVICE, device);
	}

	public List findByBranch(Object branch) {
		return findByProperty(BRANCH, branch);
	}

	public List findAll() {
		log.debug("finding all UpdatedBug instances");
		try {
			String queryString = "from UpdatedBug";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public UpdatedBug merge(UpdatedBug detachedInstance) {
		log.debug("merging UpdatedBug instance");
		try {
			UpdatedBug result = (UpdatedBug) getSession().merge(
					detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(UpdatedBug instance) {
		log.debug("attaching dirty UpdatedBug instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(UpdatedBug instance) {
		log.debug("attaching clean UpdatedBug instance");
		try {
			getSession().buildLockRequest(LockOptions.NONE).lock(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}