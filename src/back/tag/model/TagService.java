package back.tag.model;

import java.util.List;

public class TagService {

	private TagDAO_interface dao;

	public TagService() {
		dao = new TagDAO();
	}

	public TagVO addTag(String tag_desc) {

		TagVO tagVO = new TagVO();

		tagVO.setTag_desc(tag_desc);
		
		dao.insert(tagVO);

		return tagVO;
	}

	//�w�d�� Struts 2 �Ϊ�
	public void addTag(TagVO tagVO) {
		dao.insert(tagVO);
	}
	
	public TagVO updateTag(String tag_no, String tag_desc) {

		TagVO tagVO = new TagVO();

		tagVO.setTag_no(tag_no);
		tagVO.setTag_desc(tag_desc);
		
		dao.update(tagVO);

		return dao.findByPrimaryKey(tag_no);
	}
	
	//�w�d�� Struts 2 �Ϊ�
	public void updateTag(TagVO tagVO) {
		dao.update(tagVO);
	}

	public void deleteTag(String tag_no) {
		dao.delete(tag_no);
	}

	public TagVO getOneTag(String tag_no) {
		return dao.findByPrimaryKey(tag_no);
	}

	public List<TagVO> getAll() {
		return dao.getAll();
	}
}
