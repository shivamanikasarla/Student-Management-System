function addStudent() {
    const name = document.getElementById('name').value;
    const rollNo = document.getElementById('rollNo').value;
    const course = document.getElementById('course').value;

    // You can send this data to your backend or update UI
    console.log(`Adding Student: ${name}, ${rollNo}, ${course}`);
}

document.getElementById('addStudentBtn').addEventListener('click', addStudent);
