def call(Map config = [:]) {
    def requirementsFile = config.get('requirementsFile', 'requirements.txt')
    def testCommand = config.get('testCommand', 'pytest -q')
    def pythonBin = config.get('pythonBin', 'python3')

    stage('Install Dependencies') {
        sh """
            ${pythonBin} -m venv .venv
            . .venv/bin/activate
            pip install --upgrade pip
            pip install -r ${requirementsFile}
        """
    }

    stage('Run Tests') {
        sh """
            . .venv/bin/activate
            ${testCommand}
        """
    }
}
