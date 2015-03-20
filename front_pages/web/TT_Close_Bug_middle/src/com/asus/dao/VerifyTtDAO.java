package com.asus.dao;

import java.util.List;
import org.hibernate.LockOptions;
import org.hibernate.Query;
import org.hibernate.criterion.Example;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * A data access object (DAO) providing persistence and search support for
 * VerifyTt entities. Transaction control of the save(), update() and delete()
 * operations can directly support Spring container-managed transactions or they
 * can be augmented to handle user-managed Spring transactions. Each of these
 * methods provides additional information for how to configure it for the
 * desired type of transaction control.
 * 
 * @see com.asus.dao.VerifyTt
 * @author MyEclipse Persistence Tools
 */
public class VerifyTtDAO extends BaseHibernateDAO {
	private static final Logger log = LoggerFactory
			.getLogger(VerifyTtDAO.class);
	// property constants
	public static final String BUG_ID = "bugId";
	public static final String TAG = "tag";
	public static final String APK_VERSION = "apkVersion";
	public static final String CHANGE_LINK = "changeLink";
	public static final String DEVICE = "device";
	public static final String BRANCH = "branch";

	public void save(VerifyTt transientInstance) {
		log.debug("saving VerifyTt instance");
		try {
			getSession().save(transientInstance);
			log.debug("save successful");
		} catch (RuntimeException re) {
			log.error("save failed", re);
			throw re;
		}
	}

	public void delete(VerifyTt persistentInstance) {
		log.debug("deleting VerifyTt instance");
		try {
			getSession().delete(persistentInstance);
			log.debug("delete successful");
		} catch (RuntimeException re) {
			log.error("delete failed", re);
			throw re;
		}
	}

	public VerifyTt findById(java.lang.Integer id) {
		log.debug("getting VerifyTt instance with id: " + id);
		try {
			VerifyTt instance = (VerifyTt) getSession().get(
					"com.asus.dao.VerifyTt", id);
			return instance;
		} catch (RuntimeException re) {
			log.error("get failed", re);
			throw re;
		}
	}

	public List findByExample(VerifyTt instance) {
		log.debug("finding VerifyTt instance by example");
		try {
			List results = getSession().createCriteria("com.asus.dao.VerifyTt")
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
		log.debug("finding VerifyTt instance with property: " + propertyName
				+ ", value: " + value);
		try {
			String queryString = "from VerifyTt as model where model."
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
		log.debug("finding all VerifyTt instances");
		try {
			String queryString = "from VerifyTt";
			Query queryObject = getSession().createQuery(queryString);
			return queryObject.list();
		} catch (RuntimeException re) {
			log.error("find all failed", re);
			throw re;
		}
	}

	public VerifyTt merge(VerifyTt detachedInstance) {
		log.debug("merging VerifyTt instance");
		try {
			VerifyTt result = (VerifyTt) getSession().merge(detachedInstance);
			log.debug("merge successful");
			return result;
		} catch (RuntimeException re) {
			log.error("merge failed", re);
			throw re;
		}
	}

	public void attachDirty(VerifyTt instance) {
		log.debug("attaching dirty VerifyTt instance");
		try {
			getSession().saveOrUpdate(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}

	public void attachClean(VerifyTt instance) {
		log.debug("attaching clean VerifyTt instance");
		try {
			getSession().buildLockRequest(LockOptions.NONE).lock(instance);
			log.debug("attach successful");
		} catch (RuntimeException re) {
			log.error("attach failed", re);
			throw re;
		}
	}
}