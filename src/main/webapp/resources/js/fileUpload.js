// fileUpload.js

function validateFiles(files) {
  const maxFileSize = 1024 * 1024; // 1MB
  const maxFileCount = 5;
  const allowedFileTypes = ['image/jpeg', 'image/png', 'image/gif'];
  
  if (files.length > maxFileCount) {
    alert(`최대 ${maxFileCount}개까지만 업로드 가능합니다.`);
    return false;
  }

  for (let i = 0; i < files.length; i++) {
    const file = files[i];

    if (!allowedFileTypes.includes(file.type)) {
      alert('이미지 파일(jpg, png, gif)만 업로드 가능합니다.');
      return false;
    }

    if (file.size > maxFileSize) {
      alert('파일 크기는 1MB 이하여야 합니다.');
      return false;
    }
  }

  return true;
}

function updateFileListUI(files) {
  const fileListContainer = document.getElementById('fileList');
  fileListContainer.innerHTML = ''; // Clear previous file list

  for (let i = 0; i < files.length; i++) {
    const file = files[i];

    const fileItem = document.createElement('div');
    fileItem.classList.add('file-item');
    fileItem.textContent = file.name;

    const deleteButton = document.createElement('button');
    deleteButton.textContent = '삭제';
    deleteButton.classList.add('delete-button');
    deleteButton.addEventListener('click', function() {
      // Remove the file from the list (logic to handle file removal needs to be added)
      fileItem.remove();
    });
    fileItem.appendChild(deleteButton);

    fileListContainer.appendChild(fileItem);
  }
}